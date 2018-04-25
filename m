Received: from eggs.gnu.org ([2001:4830:134:3::10]:39987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB85L-0003gR-Of
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fB85J-0007DP-4I
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:14:59 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fB85I-0007D9-VN
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 20:14:57 -0400
Received: by mail-pg0-x242.google.com with SMTP id j11so12026650pgf.2
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 17:14:56 -0700 (PDT)
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <436cba94-223d-58f1-29d8-3d0610741d50@linaro.org>
Date: Tue, 24 Apr 2018 14:14:51 -1000
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 15/46] tests/tcg/multiarch: move most
 output to stdout
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
> The default test run outputs to stdout so it can be re-directed.
> Errors are still reported to stderr.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/multiarch/test-mmap.c | 38 ++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
