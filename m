Received: from eggs.gnu.org ([2001:4830:134:3::10]:38649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgU8S-00026M-3R
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cgU8P-0006ZO-0B
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:27:00 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <1487755788-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1487755788-16415-2-git-send-email-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f19b6f37-50cd-21eb-fa67-297711a9273e@twiddle.net>
Date: Wed, 22 Feb 2017 21:26:48 +1100
MIME-Version: 1.0
In-Reply-To: <1487755788-16415-2-git-send-email-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/11] target/ppc: move cpu_[read,
 write]_xer to cpu.c
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

On 02/22/2017 08:29 PM, Nikunj A Dadhania wrote:
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/Makefile.objs |  1 +
>  target/ppc/cpu.c         | 36 ++++++++++++++++++++++++++++++++++++
>  target/ppc/cpu.h         | 14 ++------------
>  3 files changed, 39 insertions(+), 12 deletions(-)
>  create mode 100644 target/ppc/cpu.c

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
