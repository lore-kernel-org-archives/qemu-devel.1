Received: from eggs.gnu.org ([2001:4830:134:3::10]:44406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fJDeh-0007Fm-Fu
	for qemu-devel@nongnu.org; Thu, 17 May 2018 03:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fJDeg-0000FE-L3
	for qemu-devel@nongnu.org; Thu, 17 May 2018 03:48:55 -0400
Date: Thu, 17 May 2018 15:48:42 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180517074842.GK6731@lemon.usersys.redhat.com>
References: <20180511222052.8734-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511222052.8734-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC 00/10] [TESTING NEEDED] python: futurize
 --stage1 (Python 3 compatibility)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

On Fri, 05/11 19:20, Eduardo Habkost wrote:
> TESTING NEEDED: Due to the amount of changes, I didn't test all
> scripts touched by this series.  If you are responsible for any
> of the touched files, I would appreciate help on testing the
> series.

The tests/docker and tests/vm changes look good to me:

Acked-by: Fam Zheng <famz@redhat.com>
