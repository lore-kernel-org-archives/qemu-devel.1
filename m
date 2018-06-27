Received: from eggs.gnu.org ([2001:4830:134:3::10]:50207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYBdx-0000YG-0V
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYBdw-00059R-7k
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:42:01 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYBdw-000590-2t
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:42:00 -0400
Received: by mail-pf0-x242.google.com with SMTP id u16-v6so1073750pfh.3
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 07:41:59 -0700 (PDT)
References: <20180625124238.25339-1-f4bug@amsat.org>
	<20180625124238.25339-45-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8f6c4300-b3bb-1274-1aa2-5fb14eb42de2@linaro.org>
Date: Wed, 27 Jun 2018 07:41:56 -0700
MIME-Version: 1.0
In-Reply-To: <20180625124238.25339-45-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 44/46] tests/crypto: Use the IEC binary
 prefix definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Stefan Weil <sw@weilnetz.de>, Eric Blake <eblake@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 06/25/2018 05:42 AM, Philippe Mathieu-Daudé wrote:
> It eases code review, unit is explicit.
> 
> Patch generated using:
> 
>   $ git grep -n '[<>][<>]= ?[1-5]0'
> 
> and modified manually.
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  tests/benchmark-crypto-cipher.c | 6 +++---
>  tests/benchmark-crypto-hash.c   | 5 +++--
>  tests/benchmark-crypto-hmac.c   | 6 +++---
>  3 files changed, 9 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
