Received: from eggs.gnu.org ([2001:4830:134:3::10]:37792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgabD-00054W-BF
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:21:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgabA-0002ul-Op
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 12:21:07 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487763883-4877-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487763883-4877-5-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <308c040c-e053-f89f-0e50-bfce496aa6bb@twiddle.net>
Date: Thu, 23 Feb 2017 04:20:57 +1100
MIME-Version: 1.0
In-Reply-To: <1487763883-4877-5-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 04/10] target/ppc: update ca32 in
 arithmetic add
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

On 02/22/2017 10:44 PM, Nikunj A Dadhania wrote:
> Adds routine to compute ca32 - gen_op_arith_compute_ca32
>
> For 64-bit mode use the compute ca32 routine. While for 32-bit mode, CA
> and CA32 will have same value.
>
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
