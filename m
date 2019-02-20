Received: from eggs.gnu.org ([209.51.188.92]:39441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWuF-0000qt-TY
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:47:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwWp7-00088b-VU
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:42:26 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:37876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwWp7-00088L-Oj
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 13:42:25 -0500
Received: by mail-pl1-x644.google.com with SMTP id q3so5279421pll.4
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 10:42:25 -0800 (PST)
References: <20190220172811.10588-1-alex.bennee@linaro.org>
	<20190220172811.10588-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1b709781-9e6c-b09c-ce48-a0b35878a20f@linaro.org>
Date: Wed, 20 Feb 2019 10:42:21 -0800
MIME-Version: 1.0
In-Reply-To: <20190220172811.10588-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 6/8] tests/docker: peg netmap code to a
 specific version
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, peter.maydell@linaro.org

On 2/20/19 9:28 AM, Alex Bennée wrote:
> Tracking head is always going to be at the whims of the upstream.
> Let's use a defined release so things don't magically change under us.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/debian-amd64.docker | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
