Received: from eggs.gnu.org ([209.51.188.92]:42718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGK3w-0000tG-CR
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hGK3v-0001eD-IM
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:07:32 -0400
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-14-david@redhat.com>
	<fb483994-1809-d628-df9b-983736c66315@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <693811a2-6d4f-b281-c6f4-ff70a7f6cbd1@redhat.com>
Date: Tue, 16 Apr 2019 11:07:26 +0200
MIME-Version: 1.0
In-Reply-To: <fb483994-1809-d628-df9b-983736c66315@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 13/41] s390x/tcg: Implement VECTOR COUNT
 TRAILING ZEROS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 13.04.19 01:23, Richard Henderson wrote:
> a ? ctz32(a) : BITS

Nice catch, thanks!

-- 

Thanks,

David / dhildenb
