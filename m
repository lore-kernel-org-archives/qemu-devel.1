Received: from eggs.gnu.org ([2001:4830:134:3::10]:45612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxqm-0007BH-AP
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxql-0000YT-Bs
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:18:52 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-13-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <720dddfe-5db4-e243-872f-7e0557eaa86c@twiddle.net>
Date: Mon, 5 Dec 2016 10:18:47 -0800
MIME-Version: 1.0
In-Reply-To: <1480937130-24561-13-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/13] target-ppc: implement xscpsgnqp
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com

On 12/05/2016 03:25 AM, Nikunj A Dadhania wrote:
> xscpsgnqp: VSX Scalar Copy Sign Quad-Precision
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target-ppc/translate/vsx-impl.inc.c | 12 +++++++++++-
>  target-ppc/translate/vsx-ops.inc.c  |  1 +
>  2 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
