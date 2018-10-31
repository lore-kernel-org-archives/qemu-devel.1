Received: from eggs.gnu.org ([2001:4830:134:3::10]:34475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gHnNn-0003oB-14
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gHnNf-0007mq-NP
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:05:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gHnNf-0007g6-Ft
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 06:05:43 -0400
Date: Wed, 31 Oct 2018 11:05:13 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181031110513.5321c17f.cohuck@redhat.com>
In-Reply-To: <20181031084309.9227-4-stefanha@redhat.com>
References: <20181031084309.9227-1-stefanha@redhat.com>
	<20181031084309.9227-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] MAINTAINERS: use 'https://' instead of
 'git://' for GitHub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Wed, 31 Oct 2018 08:43:08 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> When you clone the repository without previous commit history, 'git://'
> doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
> since the client verifies the server certificate.
> 
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 74 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
