Received: from eggs.gnu.org ([2001:4830:134:3::10]:37989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewjTm-00043s-CR
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 03:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewjTh-0002Sv-OI
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 03:08:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35308 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ewjTh-0002Sa-KT
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 03:08:37 -0400
Date: Fri, 16 Mar 2018 15:08:19 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180316070819.GB27549@lemon.usersys.redhat.com>
References: <1521169105-32041-1-git-send-email-suhang16@mails.ucas.ac.cn>
	<20180316061520.GA27549@lemon.usersys.redhat.com>
	<55c3c49b.14dfc.1622d81fc86.Coremail.suhang16@mails.ucas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55c3c49b.14dfc.1622d81fc86.Coremail.suhang16@mails.ucas.ac.cn>
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, qemu-devel@nongnu.org

On Fri, 03/16 14:31, Su Hang wrote:
> Because I generate my first patch on master, it should work.

Nope. "git am" doesn't know to resolve the conflict automatically despite it
being straightforward, unfortunately:

http://patchew.org/QEMU/1521169105-32041-1-git-send-email-suhang16@mails.ucas.ac.cn/

Fam
