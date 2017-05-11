Received: from eggs.gnu.org ([2001:4830:134:3::10]:57446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d8iiY-0000Vf-3P
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d8ihd-0006mO-LG
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:40:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d8ihd-0006hv-B2
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:40:01 -0400
Message-ID: <1494488396.17970.2.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 11 May 2017 09:39:56 +0200
In-Reply-To: <1494449551-20227-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1494449551-20227-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 0/2] cg3/tcx: make display updates thread
 safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org

On Mi, 2017-05-10 at 21:52 +0100, Mark Cave-Ayland wrote:
> Now the previous fixes/cleanups have been applied, it is a fairly trivial
> exercise to make cg3/tcx display updates thread safe.
>=20
> Gerd, do you want to take these patches via your vga queue?

Can do that, I have some more pending patches for that anyway.

cheers,
  Gerd
