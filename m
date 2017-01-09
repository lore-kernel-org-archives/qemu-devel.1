Received: from eggs.gnu.org ([2001:4830:134:3::10]:43604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQZ0C-0003bU-Qo
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cQZ09-0006zI-OD
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:24:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cQZ09-0006yN-I9
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 07:24:37 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBF6761B9A
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 12:24:37 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170104125218.26583-1-pbonzini@redhat.com>
Date: Mon, 09 Jan 2017 13:24:34 +0100
In-Reply-To: <20170104125218.26583-1-pbonzini@redhat.com> (Paolo Bonzini's
	message of "Wed, 4 Jan 2017 13:52:18 +0100")
Message-ID: <87vatomnel.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hxtool: emit Texinfo headings as
 @subsection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Remove the colon, and add it in qemu-options-wrapper.h instead.
> The introduction of @subsection also found a case where the table
> was not closed and reopened around a heading, so fix it.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
