Received: from eggs.gnu.org ([2001:4830:134:3::10]:43990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNXN-0006db-Kc
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNXK-0004MV-Hr
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:06:01 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:36105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNNXK-0004MJ-Bv
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:05:58 -0400
Received: by mail-pf0-x229.google.com with SMTP id x63so72749928pff.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 11:05:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1497937927-19738-1-git-send-email-thuth@redhat.com>
	<1497937927-19738-3-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <04a2c2e8-c304-9ed9-6a76-341925c4577e@twiddle.net>
Date: Tue, 20 Jun 2017 11:05:55 -0700
MIME-Version: 1.0
In-Reply-To: <1497937927-19738-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/8] include/exec/poison: Mark some
 CONFIG defines as poisoned, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 06/19/2017 10:52 PM, Thomas Huth wrote:
> These are defined in config-target.h and thus should never be
> used in common code.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   include/exec/poison.h | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
