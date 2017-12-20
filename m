Received: from eggs.gnu.org ([2001:4830:134:3::10]:36744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eRhbk-0002lz-KW
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:52:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eRhbh-0007W6-Pe
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:52:40 -0500
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:42842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eRhbh-0007VI-IM
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:52:37 -0500
Received: by mail-pg0-x22b.google.com with SMTP id q67so2910365pga.9
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 08:52:37 -0800 (PST)
References: <20171219151636.5162-1-michael.weiser@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7a40f48f-b415-ce95-e54b-e4c85df8a4b2@linaro.org>
Date: Wed, 20 Dec 2017 08:52:33 -0800
MIME-Version: 1.0
In-Reply-To: <20171219151636.5162-1-michael.weiser@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/4] Add aarch64_be-linux-user target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Weiser <michael.weiser@gmx.de>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 12/19/2017 07:16 AM, Michael Weiser wrote:
> Michael Weiser (4):
>   linux-user: Add support for big-endian aarch64
>   linux-user: Add separate aarch64_be uname
>   linux-user: Fix endianess of aarch64 signal trampoline
>   configure: Add aarch64_be-linux-user target

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
