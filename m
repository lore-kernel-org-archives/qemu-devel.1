Received: from eggs.gnu.org ([2001:4830:134:3::10]:40457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eK6rm-0005C5-Bj
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:13:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eK6rh-0003ek-EF
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 13:13:50 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-13-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fb55569e-dfff-6e4f-713c-abe44eaaf68d@twiddle.net>
Date: Wed, 29 Nov 2017 18:13:41 +0000
MIME-Version: 1.0
In-Reply-To: <20171128203326.6062-13-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 12/15] s390x/tcg: use
 program_interrupt_ra() in SACF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 11/28/2017 08:33 PM, David Hildenbrand wrote:
> Convert this user, too.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cc_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
