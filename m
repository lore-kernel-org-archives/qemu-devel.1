Received: from eggs.gnu.org ([2001:4830:134:3::10]:38834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gHNoh-0004fK-19
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gHNog-0004Br-76
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:47:54 -0400
References: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
	<20181029134000.11157-9-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <d5fa904d-aad5-a8fb-4347-355ac8f5f665@reactos.org>
Date: Tue, 30 Oct 2018 07:47:42 +0100
MIME-Version: 1.0
In-Reply-To: <20181029134000.11157-9-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 08/11] hw/m68k: add Nubus support for
 macfb video card
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, jasowang@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, afaerber@suse.de, aurelien@aurel32.net, laurent@vivier.eu

Le 29/10/2018 à 14:39, Mark Cave-Ayland a écrit :
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/display/macfb.c         | 56 ++++++++++++++++++++++++++++++++++++++++++++++
>   include/hw/display/macfb.h | 21 +++++++++++++++++
>   2 files changed, 77 insertions(+)

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
