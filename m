Received: from eggs.gnu.org ([2001:4830:134:3::10]:41199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB8Cw-00065q-BJ
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB8Ct-0001pV-6U
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:22:50 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:38719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fB8Ct-0001pA-04
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:22:47 -0400
Received: by mail-pg0-x243.google.com with SMTP id b5so12037754pgv.5
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 17:22:46 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-20-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f240ac9c-c8b4-2af6-3beb-4e90f415ab6a@linaro.org>
Date: Tue, 24 Apr 2018 14:22:40 -1000
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 19/46] tests/tcg/i386: Build fix for
 hello-i386
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

On 04/24/2018 05:23 AM, Alex Bennée wrote:
> From: Fam Zheng <famz@redhat.com>
> 
> We have -Werror=missing-prototype, add a dummy prototype to avoid that
> warning.
> 
> Signed-off-by: Fam Zheng <famz@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/tcg/i386/hello-i386.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
