Received: from eggs.gnu.org ([2001:4830:134:3::10]:57154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7dI-0003uy-A9
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7dH-0002Ug-Cm
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:07:44 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7dH-0002UT-85
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:07:43 -0400
Received: by mail-qt0-x241.google.com with SMTP id c20so24707928qte.0
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:07:43 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-14-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0fd4af20-ed4c-7152-dfaa-cfb8a5c6ad67@twiddle.net>
Date: Mon, 3 Jul 2017 13:07:37 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-14-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/22] exec: elide calls to tb_lock and
 tb_unlock
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
> Adding assertions fixes link errors.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   exec.c | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
