Received: from eggs.gnu.org ([2001:4830:134:3::10]:51044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVuPK-0005YR-Ua
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:48:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dVuPH-0000N8-0o
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:48:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44476)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dVuPG-0000M3-Qa
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 02:48:54 -0400
Date: Fri, 14 Jul 2017 14:48:50 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170714064850.GE18687@lemon>
References: <20170712075528.22770-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170712075528.22770-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] Two small improvements for docker.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Wed, 07/12 15:55, Fam Zheng wrote:
> The first one is a small simplification, the second one is an error handling
> improvement.
> 
> Fam Zheng (2):
>   docker.py: Drop infile parameter
>   docker.py: Improve subprocess exit code handling

Thanks, queued:

    https://github.com/famz/qemu/tree/staging
