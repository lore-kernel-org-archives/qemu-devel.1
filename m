Received: from eggs.gnu.org ([2001:4830:134:3::10]:54982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9H7r-0004eE-Lw
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9H7n-00027m-Nu
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:29:55 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:37727)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9H7n-00026y-I1
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:29:51 -0400
Received: by mail-pf0-x236.google.com with SMTP id p6so3248533pfn.4
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:29:51 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-26-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <88afc183-8015-be26-78e5-f0ec8d3e252b@linaro.org>
Date: Thu, 19 Apr 2018 11:29:46 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-26-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 25/43] tests/tcg: move ARM specific
 tests into subdir
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
> These only need to be built for ARM guests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2
>   - do VPATH manipulation in tests/tcg/arm/Makefile.target
>   - merge with fix hello-arm test
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
