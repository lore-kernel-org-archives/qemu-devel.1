Received: from eggs.gnu.org ([2001:4830:134:3::10]:51465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqCKr-0008KA-6v
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 01:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqCKm-0004AN-AS
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 01:32:29 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32820 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eqCKm-0004A4-4j
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 01:32:24 -0500
References: <1519533358-13759-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<1519533358-13759-2-git-send-email-suhang16@mails.ucas.ac.cn>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <23266f89-6d25-b751-7834-1b60881a84f7@redhat.com>
Date: Mon, 26 Feb 2018 07:32:10 +0100
MIME-Version: 1.0
In-Reply-To: <1519533358-13759-2-git-send-email-suhang16@mails.ucas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 RFC 1/3] util/uri.c: Coding style check,
 Only whitespace involved. Using `clang-format -i util/uri.c` first,
 then change back few code manually, to make sure only whitespace involved.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>, boxafox@163.com
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

On 25.02.2018 05:35, Su Hang wrote:
> Signed-off-by: Su Hang <suhang16@mails.ucas.ac.cn>

Looks like the patch description accidentally somehow moved into the
"Subject" line ... but I hope that can be fixed when the patch is picked
up, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>
