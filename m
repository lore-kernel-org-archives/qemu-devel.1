Received: from eggs.gnu.org ([2001:4830:134:3::10]:53826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPDP-0000aW-Md
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsPDL-00014p-L9
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:14:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsPDL-00014U-GK
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 05:14:07 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180821123926.17412-1-jialina01@baidu.com> (jialina's message
	of "Tue, 21 Aug 2018 20:39:26 +0800")
References: <20180821123926.17412-1-jialina01@baidu.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Aug 2018 11:14:00 +0200
Message-ID: <87ftz67oh3.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qapi/migration.json: fix the description
 for "query-migrate" output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jialina01@baidu.com
Cc: eblake@redhat.com, armbru@redhat.com, dgilbert@redhat.com, qemu-devel@nongnu.org, chaiwen <chaiwen@baidu.com>

<jialina01@baidu.com> wrote:
> From: jialina01 <jialina01@baidu.com>
>
> In the return for command "query-migrate", time information like
> "total-time", "setup-time", "downtime", is not included in ram
> json-object.
>
> So fix the description in migration.json by unpacking those information
> from ram json-object.
>
> Signed-off-by: jialina01 <jialina01@baidu.com>
> Signed-off-by: chaiwen <chaiwen@baidu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued
