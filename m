Received: from eggs.gnu.org ([209.51.188.92]:36880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hDw4F-0003H1-7C
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hDw4E-0004cL-Cc
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:05:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hDw4E-0004bf-1O
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:05:58 -0400
References: <20190307144126.31847-1-richard.henderson@linaro.org>
	<be62e92e-de46-b3a5-9945-a410049d25d5@redhat.com>
	<d4fc4ba0-bbad-b64a-ad5d-1d964717b749@linaro.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <371b33cf-469f-245c-d18f-0847340e841a@redhat.com>
Date: Tue, 9 Apr 2019 21:05:55 +0200
MIME-Version: 1.0
In-Reply-To: <d4fc4ba0-bbad-b64a-ad5d-1d964717b749@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/9] tcg: Add tcg_gen_extract2_{i32,i64}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 09.04.19 21:02, Richard Henderson wrote:
> On 4/9/19 8:53 AM, David Hildenbrand wrote:
>> On 07.03.19 15:41, Richard Henderson wrote:
>>> The primary motivator here is usage within s390x,
>>> but (as with any good primitive) the opcode has
>>> applications outside that.
>>
>> I am planning to send the next big part of vector instruction support
>> (Vector Integer Instructions) soon, that would make use of these patches.
> 
> I'll be sure to get them into the first pull after 4.1 opens.
> 

Nice, I'll be posting the next series, referencing this series (might
take some days as the amount of instructions is getting out of hand).
Thanks!


-- 

Thanks,

David / dhildenb
