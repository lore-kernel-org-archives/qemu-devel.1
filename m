Received: from eggs.gnu.org ([2001:4830:134:3::10]:50079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6lN-0001Vw-3m
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:34:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gC6lM-0001ij-AJ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:34:41 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43381)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gC6lJ-0001ez-TM
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:34:38 -0400
Received: by mail-pg1-x544.google.com with SMTP id 80-v6so9483277pgh.10
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 10:34:35 -0700 (PDT)
References: <20181005154910.3099-1-alex.bennee@linaro.org>
	<20181005154910.3099-21-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <66e9579a-f7ab-af1e-0641-2fbf8e300188@linaro.org>
Date: Mon, 15 Oct 2018 10:34:31 -0700
MIME-Version: 1.0
In-Reply-To: <20181005154910.3099-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 20/21] plugins: add hotness summary to
 hotblocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, cota@braap.org, vilanova@ac.upc.edu, Pavel.Dovgaluk@ispras.ru

On 10/5/18 8:49 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  trace/plugins/hotblocks/hotblocks.c | 33 ++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)

Oh, haha.  Ignore the first half of my comment for the previous patch.


r~
