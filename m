Received: from eggs.gnu.org ([2001:4830:134:3::10]:58209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7gU-0007Pk-VK
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7gR-000652-NS
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:11:02 -0400
Received: from mail-qk0-x22b.google.com ([2607:f8b0:400d:c09::22b]:36048)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7gR-00064G-I2
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:10:59 -0400
Received: by mail-qk0-x22b.google.com with SMTP id p21so154268449qke.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:10:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-16-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3c953e8c-59b0-5083-285b-0c85aa6dc598@twiddle.net>
Date: Mon, 3 Jul 2017 13:10:54 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-16-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 15/22] tcg: add the CONFIG_TCG into
 Makefiles
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
> From: Yang Zhong<yang.zhong@intel.com>
> 
> Add the CONFIG_TCG for frontend and backend's files in the related
> Makefiles.
> 
> Signed-off-by: Yang Zhong<yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   Makefile.target     | 4 ++--
>   accel/Makefile.objs | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
