Received: from eggs.gnu.org ([2001:4830:134:3::10]:59856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewieg-0003sj-Fa
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 02:15:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewiec-0007wz-Cw
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 02:15:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ewiec-0007rY-8s
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 02:15:50 -0400
Date: Fri, 16 Mar 2018 14:15:20 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180316061520.GA27549@lemon.usersys.redhat.com>
References: <1521169105-32041-1-git-send-email-suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521169105-32041-1-git-send-email-suhang16@mails.ucas.ac.cn>
Subject: Re: [Qemu-devel] [PATCH v2] scripts/checkpatch.pl: Bug fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Su Hang <suhang16@mails.ucas.ac.cn>
Cc: peter.maydell@linaro.org, eblake@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org

On Fri, 03/16 10:58, Su Hang wrote:
> (Sorry, I don't know this patch should base on which commit,
>  so I generate this patch based on
>  commit:fb8446d94ec7a3dc0c3a7e7da672406476f075ac,
>  I choose this by `git log -2 scripts/checkpath.pl`.
>  Sincerely say sorry, if I have misunderstand any meaning.)

This should base on master. Basing on an older commit will only make it hard for
maintainers to apply it.

(Don't be sorry at all, thank you for spending your time improving QEMU!)

Fam
