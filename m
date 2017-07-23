Received: from eggs.gnu.org ([2001:4830:134:3::10]:55779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZKCc-0001RA-QL
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:57:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZKCZ-0001SM-Qt
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:57:58 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dZKCZ-0001Rq-L9
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:57:55 -0400
Received: by mail-pf0-x241.google.com with SMTP id 1so603390pfi.3
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 09:57:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500648359-25931-1-git-send-email-thuth@redhat.com>
	<1500648359-25931-6-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <26e8ccc2-1616-b6bd-e5ed-0ed322445076@twiddle.net>
Date: Sun, 23 Jul 2017 09:57:52 -0700
MIME-Version: 1.0
In-Reply-To: <1500648359-25931-6-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/5] target/s390x: Add remaining
 switches to compile with --disable-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On 07/21/2017 07:45 AM, Thomas Huth wrote:
> Adding some CONFIG_TCG tests to be finally able to compile QEMU
> on s390x also without TCG.
> 
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   target/s390x/Makefile.objs | 6 +++---
>   target/s390x/cpu.c         | 4 ++++
>   2 files changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
