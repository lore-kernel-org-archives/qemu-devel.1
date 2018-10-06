Received: from eggs.gnu.org ([2001:4830:134:3::10]:44232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8pwc-0000JU-Ek
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 13:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g8pwY-00048n-Eb
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 13:00:46 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45831)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g8pwY-00047x-8j
	for qemu-devel@nongnu.org; Sat, 06 Oct 2018 13:00:42 -0400
Received: by mail-pf1-x443.google.com with SMTP id u12-v6so3356479pfn.12
	for <qemu-devel@nongnu.org>; Sat, 06 Oct 2018 10:00:42 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f2e3e296-34fc-c5dc-73e7-23e8444d2e0b@linaro.org>
Date: Sat, 6 Oct 2018 10:00:38 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 02/21] util/log: add
 qemu_dfilter_append_range()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: cota@braap.org, vilanova@ac.upc.edu, Pavel.Dovgaluk@ispras.ru

On 10/5/18 8:48 AM, Alex Bennée wrote:
> This allows us to add to the dfilter range as we go.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/qemu/log.h | 1 +
>  util/log.c         | 6 ++++++
>  2 files changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
