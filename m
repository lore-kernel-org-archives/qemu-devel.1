Received: from eggs.gnu.org ([2001:4830:134:3::10]:44091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxmU-000408-BO
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cDxmT-0007Fv-KF
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:14:26 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1480937130-24561-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1480937130-24561-11-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2e08748d-22db-ca20-a46c-d0219a3ce419@twiddle.net>
Date: Mon, 5 Dec 2016 10:14:22 -0800
MIME-Version: 1.0
In-Reply-To: <1480937130-24561-11-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/13] target-ppc: implement
 xsabsqp/xsnabsqp instruction
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
> xsabsqp:  VSX Scalar Absolute Quad-Precision
> xsnabsqp: VSX Scalar Negative Absolute Quad-Precision
> 
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target-ppc/translate/vsx-impl.inc.c | 35 +++++++++++++++++++++++++++++++++++
>  target-ppc/translate/vsx-ops.inc.c  |  5 +++++
>  2 files changed, 40 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
