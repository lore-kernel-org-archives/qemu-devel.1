Received: from eggs.gnu.org ([2001:4830:134:3::10]:48863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dlB72-0004c5-FY
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:41:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dlB6y-0004vC-IX
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 05:41:12 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170824120601.26963-5-el13635@mail.ntua.gr>
References: <20170824120601.26963-1-el13635@mail.ntua.gr>
	<20170824120601.26963-5-el13635@mail.ntua.gr>
Date: Fri, 25 Aug 2017 11:41:05 +0200
Message-ID: <w511so0vvbi.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 4/6] block: convert ThrottleGroup to
 object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Thu 24 Aug 2017 02:05:59 PM CEST, Manos Pitsidianakis wrote:
> ThrottleGroup is converted to an object. This will allow the future
> throttle block filter drive easy creation and configuration of throttle
> groups in QMP and cli.

Stefan pointed out a couple of important things in a reply to v7 of this
patch, but everything else looks good to me now.

Berto
