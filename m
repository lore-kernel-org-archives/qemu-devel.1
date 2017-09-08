Received: from eggs.gnu.org ([2001:4830:134:3::10]:39076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFt3-0004I4-8M
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqFsy-0004mk-Pv
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:47:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqFsy-0004lj-Jq
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:47:40 -0400
Date: Fri, 8 Sep 2017 17:47:37 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170908094737.GK4511@lemon>
References: <20170907141245.31946-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170907141245.31946-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] docker: Update ubuntu and test-full
 for more coverage
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

On Thu, 09/07 22:12, Fam Zheng wrote:
> v2: Exit if cd failed. [Eric]
> 
> Fam Zheng (2):
>   docker: Update ubuntu image
>   docker: Enable features explicitly in test-full

I'll include this in a coming pull request, thanks.

Fam
