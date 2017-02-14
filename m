Received: from eggs.gnu.org ([2001:4830:134:3::10]:32845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdcw2-0002YY-QW
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:14:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdcvy-0004LI-Od
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:14:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cdcvy-0004Ke-J6
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 08:14:18 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170210110359.8210-1-dgilbert@redhat.com>
Date: Tue, 14 Feb 2017 14:14:15 +0100
In-Reply-To: <20170210110359.8210-1-dgilbert@redhat.com> (David Alan Gilbert's
	message of "Fri, 10 Feb 2017 11:03:59 +0000")
Message-ID: <87a89oap94.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] migration: Update docs to discourage
 version bumps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peter.maydell@linaro.org

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Version bumps break backwards migration; update the docs
> to explain to people that's bad and how to avoid it.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
