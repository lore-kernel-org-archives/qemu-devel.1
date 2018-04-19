Received: from eggs.gnu.org ([2001:4830:134:3::10]:41726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9Gkq-0006c1-T9
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9Gkn-0007S7-PA
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:06:08 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:32983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9Gkn-0007Rn-JN
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:06:05 -0400
Received: by mail-pf0-x230.google.com with SMTP id f15so3226710pfn.0
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:06:05 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1eefa1e6-c89e-946c-9a0c-20af998f76fb@linaro.org>
Date: Thu, 19 Apr 2018 11:05:59 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 07/43] Makefile: Rename TARGET_DIRS to
 TARGET_LIST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/19/2018 03:58 AM, Alex Bennée wrote:
> From: Fam Zheng <famz@redhat.com>
> 
> To be more accurate on its purpose and make code that looks for a certain
> target out of this variable more readable.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  Makefile               | 20 ++++++++++----------
>  configure              |  2 +-
>  scripts/create_config  |  2 +-
>  tests/Makefile.include |  2 +-
>  4 files changed, 13 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
