Received: from eggs.gnu.org ([2001:4830:134:3::10]:50904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eX6RC-0003Ij-1T
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:24:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eX6R4-0001y4-HC
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:24:05 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:64130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eX6R4-0001vV-7G
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 09:23:58 -0500
Date: Thu, 4 Jan 2018 15:23:56 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180104142356.6hoar52jcoxrobgn@var.youpi.perso.aquilenet.fr>
References: <1515068847-20311-1-git-send-email-thuth@redhat.com>
	<20180104132600.ikr4migzznhantmt@var.youpi.perso.aquilenet.fr>
	<8590ff50-6b1a-c85f-c9fb-a70ebf8132b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8590ff50-6b1a-c85f-c9fb-a70ebf8132b5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] usb: Remove legacy -usbdevice option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: kraxel@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Thomas Huth, on jeu. 04 janv. 2018 15:22:25 +0100, wrote:
> On 04.01.2018 14:26, Samuel Thibault wrote:
> I think it's more common to not do any magic default setup with
> "-device", but if you think this should be the case here, it can
> certainly be added again

Yes, please: it will almost never be used differently than with just a
fresh braille chardev.

Samuel
