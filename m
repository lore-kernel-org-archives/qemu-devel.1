Received: from eggs.gnu.org ([2001:4830:134:3::10]:53751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eu0dM-0007ij-EY
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:51:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eu0dH-0004yc-5U
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:51:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48742 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eu0dG-0004yW-WE
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 13:51:15 -0500
References: <1520415568-19070-1-git-send-email-thuth@redhat.com>
	<c902a158-1d19-d271-ea49-f5a2f72347bd@ilande.co.uk>
	<2aa2df96-b1c3-deef-9fbf-a2560f58d17d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe05591f-9f16-228c-7d8c-65eb04a941ab@redhat.com>
Date: Thu, 8 Mar 2018 19:51:12 +0100
MIME-Version: 1.0
In-Reply-To: <2aa2df96-b1c3-deef-9fbf-a2560f58d17d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/sparc/sun4m: Fix implicit creation of
 "-drive if=scsi" devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>

On 08/03/2018 05:33, Thomas Huth wrote:
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Queued, thanks.

Paolo
