Received: from eggs.gnu.org ([2001:4830:134:3::10]:49591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwd0m-0003D6-6M
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:42:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwd0g-0002dU-R8
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:42:04 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:49825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwd0g-0002dC-KI
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 19:41:58 -0400
Received: by mail-pg0-x229.google.com with SMTP id m30so4906826pgn.6
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 16:41:58 -0700 (PDT)
References: <20170918160012.4317-1-david@redhat.com>
	<20170918160012.4317-16-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20d9ef43-93bc-6dfa-5e51-681771977500@linaro.org>
Date: Mon, 25 Sep 2017 16:41:54 -0700
MIME-Version: 1.0
In-Reply-To: <20170918160012.4317-16-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 15/27] s390x/kvm: drop two debug prints
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com, Alexander Graf <agraf@suse.de>, Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Matthew Rosato <mjrosato@linux.vnet.ibm.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 09/18/2017 09:00 AM, David Hildenbrand wrote:
> Preparation for moving it out of kvm.c.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/kvm.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
