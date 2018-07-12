Received: from eggs.gnu.org ([2001:4830:134:3::10]:34990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdbtz-0001Fz-NY
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdbtv-0004uQ-6q
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:44:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41772 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fdbtv-0004t1-1h
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:44:55 -0400
References: <20180711141829.17406-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dc616832-f9ae-ee64-bcce-012d577e2435@redhat.com>
Date: Thu, 12 Jul 2018 15:44:47 +0200
MIME-Version: 1.0
In-Reply-To: <20180711141829.17406-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Add a CentOS test image to run
 docker tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 11/07/2018 16:18, Fam Zheng wrote:
> The last patch adds the new image that does the job. Two out of three docker
> tests running on patchew.org are added to the image. I'll wait for Peter to fix
> the 'docker-test-quick@centos6' hanging (oob test) before adding it too.

The last comment is probably obsolete?

Paolo
