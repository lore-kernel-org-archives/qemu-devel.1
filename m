Received: from eggs.gnu.org ([2001:4830:134:3::10]:36129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d97Rp-00020U-RH
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:05:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d97Rm-0003EY-OP
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:05:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d97Rm-0003DL-IB
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:05:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8BF2FC05973F
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 10:05:16 +0000 (UTC)
Message-ID: <1494583514.14352.58.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 May 2017 12:05:14 +0200
In-Reply-To: <1494256429-31720-1-git-send-email-thuth@redhat.com>
References: <1494256429-31720-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v4] qemu-doc: Update to use the new way of
 attaching USB devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On Mo, 2017-05-08 at 17:13 +0200, Thomas Huth wrote:
> The preferred way of adding USB devices is via "-device" and
> "device_add" nowadays, so let's start to get rid of "-usbdevice"
> and "usb_add" in the documentation. While we're at it, also
> add the new USB devices there which have been added to QEMU
> during the last years, and get rid of the old "vendorid" and
> "productid" parameters of "-usbdevice serial" which have been
> removed in QEMU version 0.14.0 already.

added to usb queue.

thanks,
  Gerd
