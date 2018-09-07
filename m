Received: from eggs.gnu.org ([2001:4830:134:3::10]:35222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fyGST-0007vZ-2Y
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fyGSO-0004gG-4G
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 09:05:57 -0400
References: <20180907125653.5010-1-mark.cave-ayland@ilande.co.uk>
	<20180907125653.5010-2-mark.cave-ayland@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ae4e458a-20a0-71d1-8b59-56a7d15f8cd7@redhat.com>
Date: Fri, 7 Sep 2018 15:05:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180907125653.5010-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] scsi: add
 lsi53c8xx_handle_legacy_cmdline() function
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
> This is the function that will soon be used to replace lsi53c895a_create() and
> lsi53c810_create().
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/scsi/lsi53c895a.c | 7 +++++++
>  include/hw/pci/pci.h | 1 +
>  2 files changed, 8 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>
