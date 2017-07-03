Received: from eggs.gnu.org ([2001:4830:134:3::10]:55948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7Yq-00080l-1j
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:03:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7Ym-0000QC-0d
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:03:08 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34351)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7Yl-0000Po-Rr
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:03:03 -0400
Received: by mail-qt0-x243.google.com with SMTP id m54so22210459qtb.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:03:03 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-11-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e5fdaf80-4161-9529-6f4c-50a854e17c29@twiddle.net>
Date: Mon, 3 Jul 2017 13:02:58 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-11-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/22] vapic: use tcg_enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

On 07/03/2017 09:34 AM, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   hw/i386/kvmvapic.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
