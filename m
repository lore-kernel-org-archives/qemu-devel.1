Received: from eggs.gnu.org ([2001:4830:134:3::10]:36356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fyGW8-0002EJ-Au
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:09:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fyGW3-0003CL-Dp
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:09:44 -0400
References: <20180907125653.5010-1-mark.cave-ayland@ilande.co.uk>
	<20180907125653.5010-4-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ac3c69b2-a3c3-d04e-9bb8-15fa6e75797a@redhat.com>
Date: Fri, 7 Sep 2018 15:09:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180907125653.5010-4-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] scsi: remove unused
 lsi53c895a_create() and lsi53c810_create() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com, famz@redhat.com, hpoussin@reactos.org, rth@twiddle.net, peter.maydell@linaro.org, armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

On 2018-09-07 14:56, Mark Cave-Ayland wrote:
> Now that these functions are no longer required they can be removed.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/scsi/lsi53c895a.c | 14 --------------
>  include/hw/pci/pci.h |  2 --
>  2 files changed, 16 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
