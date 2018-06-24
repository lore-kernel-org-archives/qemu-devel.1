Received: from eggs.gnu.org ([2001:4830:134:3::10]:58285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXDsc-0001GC-P8
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 18:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fXDsY-0008Si-5Z
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 18:53:10 -0400
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:42802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fXDsX-0008SO-Vj
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 18:53:06 -0400
Received: by mail-pg0-x234.google.com with SMTP id c10-v6so5207733pgu.9
	for <qemu-devel@nongnu.org>; Sun, 24 Jun 2018 15:53:05 -0700 (PDT)
References: <20180622141205.16306-1-alex.bennee@linaro.org>
	<20180622141205.16306-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ff614298-44b0-840a-94dc-817895cb5712@linaro.org>
Date: Sun, 24 Jun 2018 15:53:01 -0700
MIME-Version: 1.0
In-Reply-To: <20180622141205.16306-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v4 12/22] contrib/generate_all.sh:
 allow passing of arguments to risugen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 06/22/2018 07:11 AM, Alex Bennée wrote:
> This allows us to use any new risugen options when generating all our
> test patterns.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  contrib/generate_all.sh | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
