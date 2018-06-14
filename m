Received: from eggs.gnu.org ([2001:4830:134:3::10]:49102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYlz-0001YZ-Hp
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:23:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTYlv-0004Oi-Rr
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:23:11 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:34125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTYlv-0004O5-Mh
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 16:23:07 -0400
Received: by mail-pf0-x244.google.com with SMTP id a63-v6so3780567pfl.1
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 13:23:07 -0700 (PDT)
References: <20180613125601.14371-1-alex.bennee@linaro.org>
	<20180613125601.14371-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <66a8689c-5822-3eb2-9798-33a6baa4a2b6@linaro.org>
Date: Thu, 14 Jun 2018 10:23:02 -1000
MIME-Version: 1.0
In-Reply-To: <20180613125601.14371-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RISU PATCH v3 15/22] risu_reginfo_aarch64: drop
 stray ;
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

On 06/13/2018 02:55 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  risu_reginfo_aarch64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
