Received: from eggs.gnu.org ([2001:4830:134:3::10]:43839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cwYbb-0007lY-2h
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 14:27:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cwYba-0003DS-4f
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 14:27:31 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170407060752.31313-1-nikunj@linux.vnet.ibm.com>
	<20170407060752.31313-4-nikunj@linux.vnet.ibm.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <115805e5-59b9-bff7-4df9-440c070e4831@twiddle.net>
Date: Fri, 7 Apr 2017 11:27:26 -0700
MIME-Version: 1.0
In-Reply-To: <20170407060752.31313-4-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/3] target/ppc: Generate fence
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, programmingkidx@gmail.com, bharata@linux.vnet.ibm.com

On 04/06/2017 11:07 PM, Nikunj A Dadhania wrote:
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target/ppc/translate.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
