Received: from eggs.gnu.org ([2001:4830:134:3::10]:35468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cH9ak-0000iW-V0
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cH9ag-0002wc-3U
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:27:31 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:34090)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cH9af-0002wT-Vo
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 08:27:26 -0500
Received: by mail-io0-f177.google.com with SMTP id p42so39679595ioo.1
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 05:27:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161214125423.GB4135@noname.redhat.com>
References: <20161213214917.6436-1-stefanha@redhat.com>
	<20161214125423.GB4135@noname.redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 14 Dec 2016 13:26:24 +0000
Message-ID: <CAJSP0QUJQfcCbDCjmOa-ZqYEBpiO2swjkwHk07hvAdUK5bTiiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] Update language files for QEMU 2.8.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefan Weil <sw@weilnetz.de>, qemu-devel <qemu-devel@nongnu.org>

On Wed, Dec 14, 2016 at 12:54 PM, Kevin Wolf <kwolf@redhat.com> wrote:
> Am 13.12.2016 um 22:49 hat Stefan Hajnoczi geschrieben:
> And would that crash be considered a release blocker, too?

If it's a regression in 2.8, then yes.  Otherwise no.

Since it's a user interface crash it's very visible to users and would
be nice to fix for 2.8 even if it's not a release blocker.  But only
if it can be fixed today, let's not hold up the release.

Stefan
