Received: from eggs.gnu.org ([2001:4830:134:3::10]:58271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZNuI-0003SJ-O1
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZNuH-0003Xf-MJ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:27:34 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:37120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZNuH-0003X5-AP
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 16:27:33 -0500
Received: by mail-pg0-x242.google.com with SMTP id z17so589630pgc.4
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 13:27:33 -0800 (PST)
References: <20180108231048.23966-1-laurent@vivier.eu>
	<20180108231048.23966-7-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <567c6446-d9b8-e93f-bdc9-b61382776680@linaro.org>
Date: Wed, 10 Jan 2018 13:27:29 -0800
MIME-Version: 1.0
In-Reply-To: <20180108231048.23966-7-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] target/m68k: add HMP command "info tlb"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 01/08/2018 03:10 PM, Laurent Vivier wrote:
> Dump MMU state and address mappings.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
