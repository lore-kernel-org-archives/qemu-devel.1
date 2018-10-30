Received: from eggs.gnu.org ([2001:4830:134:3::10]:38287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gHNnV-0003r7-0j
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gHNnQ-00033J-7m
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 02:46:39 -0400
References: <20181029134000.11157-1-mark.cave-ayland@ilande.co.uk>
	<20181029134000.11157-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <94f027a2-1f30-4ab0-0c04-3039041edf69@reactos.org>
Date: Tue, 30 Oct 2018 07:46:04 +0100
MIME-Version: 1.0
In-Reply-To: <20181029134000.11157-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 01/11] hw/m68k: add via support
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
> From: Laurent Vivier <laurent@vivier.eu>
> 
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   hw/misc/Makefile.objs     |   1 +
>   hw/misc/mac_via.c         | 666 ++++++++++++++++++++++++++++++++++++++++++++++
>   include/hw/misc/mac_via.h | 107 ++++++++
>   3 files changed, 774 insertions(+)
>   create mode 100644 hw/misc/mac_via.c
>   create mode 100644 include/hw/misc/mac_via.h

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
