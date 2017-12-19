Received: from eggs.gnu.org ([2001:4830:134:3::10]:51128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRPrH-0001fX-Ce
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 16:55:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eRPrC-0007q8-Ik
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 16:55:30 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20171219173425.8113-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d83a2802-c5a6-531b-321a-599ed16973d9@redhat.com>
Date: Tue, 19 Dec 2017 22:54:49 +0100
MIME-Version: 1.0
In-Reply-To: <20171219173425.8113-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/9] iotests: python3 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Nir Soffer <nirsof@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Ishani Chugh <chugh.ishani@research.iiit.ac.in>

On 19/12/2017 18:34, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> This is a very boring series.
> 
> I a later series I refactor the iotests.py class, however when the first version
> of series [1] was posted I received comments that this class should no support
> Python 3.
> 
> I didn't tested with very old CentOS release, but this should work with Python
> versions >= 2.6.0a2.

Thanks, this is useful.  However, it'd be much easier if the commit
messages showed the actual error message that is fixed, or an example.

Paolo
