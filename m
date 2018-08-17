Received: from eggs.gnu.org ([2001:4830:134:3::10]:37142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqiUk-00024c-P3
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fqiUe-0000D0-4U
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:25:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34570 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fqiUd-0000CL-Uu
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:25:00 -0400
References: <1512683181-8420-1-git-send-email-minyard@acm.org>
	<1512683181-8420-2-git-send-email-minyard@acm.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3d8659d1-57ba-3043-7098-5b74c28c34bb@redhat.com>
Date: Fri, 17 Aug 2018 19:24:52 +0200
MIME-Version: 1.0
In-Reply-To: <1512683181-8420-2-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/14] i2c:pm_smbus: Clean up some style
 issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S . Tsirkin" <mst@redhat.com>

On 07/12/2017 22:46, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
> 
> Fix some spacing issues, remove extraneous comments, add some
> defines instead of hard-coding numbers.
> 
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/i2c/pm_smbus.c | 58 ++++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 38 insertions(+), 20 deletions(-)

Hi Corey, I just found this patch and the rest of the series.  If it
still applies, could you please resend it?

Thanks,

Paolo
