Received: from eggs.gnu.org ([2001:4830:134:3::10]:57388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gL4PT-0002ww-6D
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gL4PM-0006UF-Cl
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:53:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gL4PL-0006TQ-Pb
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 05:52:59 -0500
Date: Fri, 9 Nov 2018 11:52:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181109105256.2xz6yivai6wsp7tl@sirius.home.kraxel.org>
References: <20181107104921.20536-1-lhrazky@redhat.com>
	<20181107104921.20536-2-lhrazky@redhat.com>
	<20181108064927.i6llxv4kgcrdon7n@sirius.home.kraxel.org>
	<1541671510.16655.506.camel@redhat.com>
	<20181109101056.oyqapawhy5jmeut4@sirius.home.kraxel.org>
	<1833668908.41731563.1541758840856.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1833668908.41731563.1541758840856.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH spice v3 1/3] QXL interface: add a
 function to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: spice-devel@lists.freedesktop.org, =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>, qemu-devel@nongnu.org

  Hi,

> first output/display:
>   spice_qxl_set_device_info(instance1, path1, 0, 1);
> second:
>   spice_qxl_set_device_info(instance2, path1, 1, 1);
> third:
>   spice_qxl_set_device_info(instance3, path1, 2, 1);

That is a much better example IMHO.

cheers,
  Gerd
