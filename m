Received: from eggs.gnu.org ([2001:4830:134:3::10]:59410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gE3mD-0006W8-O0
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 22:47:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gE3mC-0003dg-0u
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 22:47:37 -0400
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:42016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gE3mB-0003dP-Rx
	for qemu-devel@nongnu.org; Sat, 20 Oct 2018 22:47:35 -0400
Received: by mail-yw1-xc41.google.com with SMTP id a197-v6so14688149ywh.9
	for <qemu-devel@nongnu.org>; Sat, 20 Oct 2018 19:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20181021024536.9748-1-jcmvbkbc@gmail.com>
In-Reply-To: <20181021024536.9748-1-jcmvbkbc@gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 20 Oct 2018 19:47:23 -0700
Message-ID: <CAMo8Bf+gOGVRbucaYVqSCfa1T2F5E7Z3kB_YLFBCiGe2cLzJHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] scripts/qemu-binfmt-conf.sh: add bFL
 handler registration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Laurent Vivier <laurent@vivier.eu>

On Sat, Oct 20, 2018 at 7:45 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> bFLT format header doesn't have enough information to register a handler
> for a specific architecture. Add switch -f / --flat that registers one
> of the qemu binaries as a handler for bFLT executable images.
>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  dtc                         |  2 +-

Oops, sorry, didn't mean to include that change. Will send v2.

-- 
Thanks.
-- Max
