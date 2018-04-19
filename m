Received: from eggs.gnu.org ([2001:4830:134:3::10]:53217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9H5Y-0002Mt-Pt
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f9H5U-0007JI-RI
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:27:32 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:38577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f9H5U-0007Fj-MI
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 17:27:28 -0400
Received: by mail-pl0-x241.google.com with SMTP id c7-v6so3993030plr.5
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:27:28 -0700 (PDT)
References: <20180419135901.30035-1-alex.bennee@linaro.org>
	<20180419135901.30035-24-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <019d3f73-98bb-8f44-d664-d6f0a7bc5447@linaro.org>
Date: Thu, 19 Apr 2018 11:27:23 -1000
MIME-Version: 1.0
In-Reply-To: <20180419135901.30035-24-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 23/43] tests/tcg/i386/test-i386: use
 modern vector_size attributes
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
> The compiler complains about the old __mode__ style attributes.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/i386/test-i386.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
