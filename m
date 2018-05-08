Received: from eggs.gnu.org ([2001:4830:134:3::10]:47353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fG8nr-0000jI-Jq
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fG8nq-0002Qa-Se
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:01:39 -0400
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:36857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fG8nq-0002QK-O2
	for qemu-devel@nongnu.org; Tue, 08 May 2018 16:01:38 -0400
Received: by mail-yw0-x244.google.com with SMTP id l15-v6so10043631ywk.3
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 13:01:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508194026.1281-2-laurent@vivier.eu>
References: <20180508194026.1281-1-laurent@vivier.eu>
	<20180508194026.1281-2-laurent@vivier.eu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 8 May 2018 13:01:36 -0700
Message-ID: <CAMo8BfKfyJTxnPZCHDcxaPn2VJppATMn0pC6HMZmkiszpa414w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/5] linux-user: define correct fcntl()
 values for sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On Tue, May 8, 2018 at 12:40 PM, Laurent Vivier <laurent@vivier.eu> wrote:
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/syscall_defs.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
