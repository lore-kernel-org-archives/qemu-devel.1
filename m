Received: from eggs.gnu.org ([2001:4830:134:3::10]:43580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6QU-0001ND-Ns
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6QS-00017H-4V
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:13:06 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:41575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC6QR-00016m-Tm
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:13:04 -0400
Received: by mail-pg1-x544.google.com with SMTP id 23-v6so9462148pgc.8
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 10:13:03 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-16-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1b2618e6-8bd6-0eed-612d-ea81a7e8d28b@linaro.org>
Date: Mon, 15 Oct 2018 10:13:00 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 15/21] trace: add linux-user plugin
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, cota@braap.org, Aaron Lindsay <aclindsa@gmail.com>, vilanova@ac.upc.edu

On 10/5/18 8:49 AM, Alex Bennée wrote:
> From: Aaron Lindsay <aclindsa@gmail.com>
> 
> Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
> [AJB: ifdeffery]
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  linux-user/main.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
