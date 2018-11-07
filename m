Received: from eggs.gnu.org ([2001:4830:134:3::10]:39847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gKJry-00038t-LK
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:11:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gKJrh-0001Iw-TM
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:11:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gKJrZ-0001BK-VG
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 04:11:04 -0500
Date: Wed, 7 Nov 2018 10:10:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181107091054.c6vqttq2ii7rgnof@sirius.home.kraxel.org>
References: <20181106112829.1948-1-kraxel@redhat.com>
	<20181106112829.1948-2-kraxel@redhat.com>
	<3ecb139d-4e06-d04c-8ae3-69ffeda78372@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ecb139d-4e06-d04c-8ae3-69ffeda78372@linux.ibm.com>
Subject: Re: [Qemu-devel] [PULL 1/1] update seabios to master snapshot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org

  Hi,

> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Thanks for taking the latest version. If this works out well, would it be
> possible to use this version of Seabios also for QEMU 3.0 stable? I am
> asking primarily due to the TPM patches and the fact that QEMU 3.0 is
> packaged in F29, with the CRB port missing in Seabios...

Fedora doesn't use the precompiled binary anyway,
so that wouldn't help ...

cheers,
  Gerd
