Received: from eggs.gnu.org ([2001:4830:134:3::10]:54570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnJLe-0007Kl-E0
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnJLd-00031q-Qo
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 02:53:06 -0400
Date: Thu, 31 Aug 2017 14:52:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170831065257.GA14896@lemon.lan>
References: <20170804143658.23020-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170804143658.23020-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu-img: Clarify about relative
 backing file options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Fri, 08/04 22:36, Fam Zheng wrote:
> It's not too surprising when a user specifies the backing file relative
> to the current working directory instead of the top layer image. This
> causes error when they differ. Though the error message has enough
> information to infer the fact about the misunderstanding, it is better
> if we document this explicitly, so that users don't have to learn from
> mistakes.

Gentle ping as a reminder for 2.11, as 2.10 is now out of door.

Fam
