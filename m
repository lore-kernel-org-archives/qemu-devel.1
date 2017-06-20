Received: from eggs.gnu.org ([2001:4830:134:3::10]:43863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNXB-0006T6-BJ
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNXA-0004Id-Ju
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:05:49 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:33082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNNXA-0004IQ-Dq
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:05:48 -0400
Received: by mail-pf0-x22e.google.com with SMTP id 83so72900394pfr.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 11:05:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1497937927-19738-1-git-send-email-thuth@redhat.com>
	<1497937927-19738-2-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <cdab714d-a0ac-c59b-78ea-c91762bb58d0@twiddle.net>
Date: Tue, 20 Jun 2017 11:05:45 -0700
MIME-Version: 1.0
In-Reply-To: <1497937927-19738-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/8] include/exec/poison: Add missing
 TARGET defines
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
> Since we've got some new CPU targets in QEMU during the last months
> and years, we've got some new TARGET_xxx defines now which should
> be marked as poisoned for common code.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   include/exec/poison.h | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
